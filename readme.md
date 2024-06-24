# overview

the following scripts extracts the geo locations of the addresses and compares with the updated address by adding the country name at the end of each address. if the geolocation is incorrect stores them in a seperate file for correction.

# instructions

```javascript
npm install
```

```javascript
change the absolute path of the fs modules in each script.
```

```javascript
npx ts-node script/01-getPropertyDetailsFromDb.ts
```

```javascript
npx ts-node script/index_worker.ts
```

# conclusion

after the script ran successfully.
in the results directory

1. matchResult.json cantains list of the address with correct coOrdinates
2. noMAtch.json contains list of addresses with incorrect CoOrdinates and their actual values
