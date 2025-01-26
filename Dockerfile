# Start from the official Ubuntu image
FROM ubuntu:latest

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    zsh \
    git \
    curl \
    fonts-powerline \
    language-pack-en \
    vim \
 && rm -rf /var/lib/apt/lists/*

# Change default shell to zsh
SHELL ["/bin/zsh", "-c"]

# Install Oh My Zsh without triggering an interactive prompt
# The `RUNZSH=no` and `CHSH=no` environment variables prevent the installer
# from trying to launch zsh or change the shell again.
RUN env RUNZSH=no CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins (zsh-autosuggestions & zsh-syntax-highlighting) 
# in the custom plugins directory used by Oh My Zsh.
RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
 && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Update the ~/.zshrc to use:
#   - agnoster theme
#   - plugins: git zsh-autosuggestions zsh-syntax-highlighting
RUN sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/' ~/.zshrc \
 && sed -i 's/^plugins=(git)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Optional: set Zsh as default shell for the container’s root user
RUN chsh -s $(which zsh) root

# By default, start in zsh
CMD ["zsh"]
