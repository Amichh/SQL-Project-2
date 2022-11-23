
Select *
From PortfolioProject.dbo.NashvilleHousing

-- Adding nwe column and updating the data type

Select SaleDatee , CONVERT(Date,SaleDate)
From PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)
ALTER TABLE NashvilleHousing
Add saledatee Date;
Update NashvilleHousing
SET saledatee = CONVERT(Date,SaleDate)

--populating Null Value 

Select a.ParcelID, a.PropertyAddress, b.ParcelID ,b.PropertyAddress, ISNULL (a.propertyaddress,b.propertyaddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
 on a.ParcelID =b.ParcelID
 and a.[UniqueID ]<>b.[UniqueID ]
 Where a.PropertyAddress is null

 Update a
 SET PropertyAddress= ISNULL (a.propertyaddress,b.propertyaddress)
 From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
 on a.ParcelID =b.ParcelID
 and a.[UniqueID ]<>b.[UniqueID ]
 Where a.PropertyAddress is null


--Splittng the Owner Address in to 3 column 

 Select OwnerAddress
 From PortfolioProject.dbo.NashvilleHousing
Select
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) 
,PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add SplitOwnerAddress Nvarchar(255);
Update NashvilleHousing
SET SplitOwnerAddress =PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE NashvilleHousing
Add SplitOwnerState Nvarchar(255);
Update NashvilleHousing
SET SplitOwnerState =PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE NashvilleHousing
Add SplitOwnerCity Nvarchar(255);

Update NashvilleHousing
SET SplitOwnerCity =PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

-- Changing the SoldAsVacant Value to Yes and No Only
--Select Distinct(SoldAsVacant), count(SoldAsVacant)
--From .NashvilleHousing
--Group by SoldAsVacant

Select SoldAsVacant
,Case When SoldAsVacant ='Y' Then 'Yes'
      When SoldASVacant ='N' Then 'No'
	  Else SoldASVacant
	  END
From.NashvilleHousing
Update NashvilleHousing
SET SoldAsVacant =Case When SoldAsVacant ='Y' Then 'Yes'
      When SoldASVacant ='N' Then 'No'
	  Else SoldASVacant
	  END

--Removing Duplicate by referncing Other column

With R AS(
Select *,ROW_NUMBER() Over(PARTITION BY ParcelID,
PropertyAddress,
SalePrice,SaleDate,
LegalReference
Order by UniqueID) row_num
From .NashvilleHousing)

DELETE
From R
Where row_num>1





--Deleting Unwanted Column from the Table
ALTER TABLE .NashvilleHousing
DROP COLUMN Saledate,OwnerAddress
