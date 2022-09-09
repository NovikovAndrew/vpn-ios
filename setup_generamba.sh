# Exit immediatly on error
set -e

cd $1
# Copy Rambafile from a similar framework
cp ../Auth/Rambafile ./
# Create short cut for the Templates folder(Referencing the folder from the rambafile does not work for some reason)
ln -s "../Templates" Templates
# Replace all occurencies of the similar framework with the new framework
sed -i '' "s/Auth/$1/g" Rambafile

cd ..
# Help commit the changes
git status
echo "Everything looks ok? Lets commit it then\ngit add $1/Rambafile $1/Templates && git commit -m \"feat: Setup generamba for $1\""
