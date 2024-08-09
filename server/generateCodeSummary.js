const fs = require('fs');
const path = require('path');

const EXCLUDED_ITEMS = ['node_modules', 'package-lock.json', 'generateCodeSummary.js', '.env', '.git', '.gitignore', 'tsconfig.json', 'server_code_summary.txt'];
const OUTPUT_FILE = 'server_code_summary.txt';

function isExcluded(filePath) {
  return EXCLUDED_ITEMS.some(item => filePath.includes(path.sep + item + path.sep) || filePath.endsWith(item));
}

function getAllFiles(dirPath, arrayOfFiles = []) {
  const files = fs.readdirSync(dirPath);

  files.forEach(file => {
    const filePath = path.join(dirPath, file);
    if (fs.statSync(filePath).isDirectory()) {
      if (!isExcluded(filePath)) {
        arrayOfFiles = getAllFiles(filePath, arrayOfFiles);
      }
    } else {
      if (!isExcluded(filePath)) {
        arrayOfFiles.push(filePath);
      }
    }
  });

  return arrayOfFiles;
}

function writeCodeSummary(filePaths, outputPath) {
  const writeStream = fs.createWriteStream(outputPath);

  filePaths.forEach(filePath => {
    writeStream.write(`\n\n=== ${filePath} ===\n\n`);
    const fileContent = fs.readFileSync(filePath, 'utf-8');
    writeStream.write(fileContent);
  });

  writeStream.end();
}

const serverDir = path.resolve(__dirname); // Adjust to your server directory
const allFiles = getAllFiles(serverDir);
writeCodeSummary(allFiles, OUTPUT_FILE);

console.log(`Server code summary written to ${OUTPUT_FILE}`);
