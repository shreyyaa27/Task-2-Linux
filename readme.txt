readme

make it executable using chmod +x internsctl.sh

./internsctl.sh cpu getinfo
./internsctl.sh memory getinfo
./internsctl.sh user create <username>
./internsctl.sh user list
./internsctl.sh user list --sudo-only
./internsctl.sh file getinfo <file-name>
./internsctl.sh file getinfo --size <file-name>
./internsctl.sh file getinfo --permissions <file-name>
./internsctl.sh file getinfo --owner <file-name>
./internsctl.sh file getinfo --last-modified <file-name>
./internsctl.sh --version
./internsctl.sh --help
