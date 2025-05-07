module Microsoft
  module Graph
    module V1
      module Models
        # Model for Microsoft's Graph User object
        # https://learn.microsoft.com/en-us/graph/api/resources/user?view=graph-rest-1.0
        #
        # Property 	Type 	Description

        # aboutMe 	String 	A freeform text entry field for the user to describe themselves. Returned only on $select.

        # accountEnabled 	Boolean 	true if the account is enabled; otherwise, false. This property is required when a user is created.
        # Returned only on $select. Supports $filter (eq, ne, not, and in).

        # ageGroup 	ageGroup 	Sets the age group of the user. Allowed values: null, Minor, NotAdult, and Adult. For more information, see legal age group property definitions.
        # Returned only on $select. Supports $filter (eq, ne, not, and in).

        # assignedLicenses 	assignedLicense collection 	The licenses that are assigned to the user, including inherited (group-based) licenses. This property doesn't differentiate between directly assigned and inherited licenses. Use the licenseAssignmentStates property to identify the directly assigned and inherited licenses. Not nullable. Returned only on $select. Supports $filter (eq, not, /$count eq 0, /$count ne 0).

        # assignedPlans 	assignedPlan collection 	The plans that are assigned to the user. Read-only. Not nullable.
        # Returned only on $select. Supports $filter (eq and not).

        # birthday 	DateTimeOffset 	The birthday of the user. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014, is 2014-01-01T00:00:00Z.
        # Returned only on $select.

        # businessPhones 	String collection 	The telephone numbers for the user. NOTE: Although it is a string collection, only one number can be set for this property. Read-only for users synced from the on-premises directory.
        # Returned by default. Supports $filter (eq, not, ge, le, startsWith).

        # city 	String 	The city where the user is located. Maximum length is 128 characters.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # companyName 	String 	The name of the company that the user is associated with. This property can be useful for describing the company that an external user comes from. The maximum length is 64 characters.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # consentProvidedForMinor 	consentProvidedForMinor 	Sets whether consent was obtained for minors. Allowed values: null, Granted, Denied and NotRequired. Refer to the legal age group property definitions for further information.
        # Returned only on $select. Supports $filter (eq, ne, not, and in).

        # country 	String 	The country or region where the user is located; for example, US or UK. Maximum length is 128 characters.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # createdDateTime 	DateTimeOffset 	The date and time the user was created, in ISO 8601 format and UTC. The value cannot be modified and is automatically populated when the entity is created. Nullable. For on-premises users, the value represents when they were first created in Microsoft Entra ID. Property is null for some users created before June 2018 and on-premises users that were synced to Microsoft Entra ID before June 2018. Read-only.
        # Returned only on $select. Supports $filter (eq, ne, not , ge, le, in).

        # creationType 	String 	Indicates whether the user account was created through one of the following methods:
        #     As a regular school or work account (null).
        #     As an external account (Invitation).
        #     As a local account for an Azure Active Directory B2C tenant (LocalAccount).
        #     Through self-service sign-up by an internal user using email verification (EmailVerified).
        #     Through self-service sign-up by an external user signing up through a link that is part of a user flow (SelfServiceSignUp).
        # Read-only.
        # Returned only on $select. Supports $filter (eq, ne, not, in).

        # customSecurityAttributes 	customSecurityAttributeValue 	An open complex type that holds the value of a custom security attribute that is assigned to a directory object. Nullable.
        # Returned only on $select. Supports $filter (eq, ne, not, startsWith). The filter value is case-sensitive.

        # deletedDateTime 	DateTimeOffset 	The date and time the user was deleted.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in).

        # department 	String 	The name of the department in which the user works. Maximum length is 64 characters.
        # Returned only on $select. Supports $filter (eq, ne, not , ge, le, in, and eq on null values).

        # displayName 	String 	The name displayed in the address book for the user. This is usually the combination of the user's first name, middle initial, and last name. This property is required when a user is created and it cannot be cleared during updates. Maximum length is 256 characters.
        # Returned by default. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values), $orderby, and $search.

        # employeeHireDate 	DateTimeOffset 	The date and time when the user was hired or will start work in a future hire.
        # Returned only on $select. Supports $filter (eq, ne, not , ge, le, in).

        # employeeLeaveDateTime 	DateTimeOffset 	The date and time when the user left or will leave the organization.
        # To read this property, the calling app must be assigned the User-LifeCycleInfo.Read.All permission. To write this property, the calling app must be assigned the User.Read.All and User-LifeCycleInfo.ReadWrite.All permissions. To read this property in delegated scenarios, the admin needs one of the following Microsoft Entra roles: Lifecycle Workflows Administrator, Global Reader, or Global Administrator. To write this property in delegated scenarios, the admin needs the Global Administrator role.
        # Supports $filter (eq, ne, not , ge, le, in).
        # For more information, see Configure the employeeLeaveDateTime property for a user.

        # employeeId 	String 	The employee identifier assigned to the user by the organization. The maximum length is 16 characters.
        # Returned only on $select. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values).

        # employeeOrgData 	employeeOrgData 	Represents organization data (for example, division and costCenter) associated with a user.
        # Returned only on $select. Supports $filter (eq, ne, not , ge, le, in).

        # employeeType 	String 	Captures enterprise worker type. For example, Employee, Contractor, Consultant, or Vendor. Returned only on $select. Supports $filter (eq, ne, not , ge, le, in, startsWith).

        # externalUserState 	String 	For an external user invited to the tenant using the invitation API, this property represents the invited user's invitation status. For invited users, the state can be PendingAcceptance or Accepted, or null for all other users.
        # Returned only on $select. Supports $filter (eq, ne, not , in).

        # externalUserStateChangeDateTime 	DateTimeOffset 	Shows the timestamp for the latest change to the externalUserState property.
        # Returned only on $select. Supports $filter (eq, ne, not , in).

        # faxNumber 	String 	The fax number of the user.
        # Returned only on $select. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values).

        # givenName 	String 	The given name (first name) of the user. Maximum length is 64 characters.
        # Returned by default. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values).

        # hireDate 	DateTimeOffset 	The hire date of the user. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014, is 2014-01-01T00:00:00Z.
        # Returned only on $select.
        # Note: This property is specific to SharePoint Online. We recommend using the native employeeHireDate property to set and update hire date values using Microsoft Graph APIs.

        # id 	String 	The unique identifier for the user. Should be treated as an opaque identifier. Inherited from directoryObject. Key. Not nullable. Read-only.
        # Returned by default. Supports $filter (eq, ne, not, in).

        # identities 	objectIdentity collection 	Represents the identities that can be used to sign in to this user account. Microsoft (also known as a local account), organizations, or social identity providers such as Facebook, Google, and Microsoft can provide identity and tie it to a user account. It may contain multiple items with the same signInType value.
        # Returned only on $select. Supports $filter (eq) including on null values, only where the signInType is not userPrincipalName.

        # imAddresses 	String collection 	The instant message voice-over IP (VOIP) session initiation protocol (SIP) addresses for the user. Read-only.
        # Returned only on $select. Supports $filter (eq, not, ge, le, startsWith).

        # interests 	String collection 	A list for the user to describe their interests.
        # Returned only on $select.

        # isResourceAccount 	Boolean 	Do not use – reserved for future use.

        # jobTitle 	String 	The user's job title. Maximum length is 128 characters.
        # Returned by default. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values).

        # lastPasswordChangeDateTime 	DateTimeOffset 	The time when this Microsoft Entra user last changed their password or when their password was created, whichever date the latest action was performed. The date and time information uses ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.
        # Returned only on $select.

        # legalAgeGroupClassification 	legalAgeGroupClassification 	Used by enterprise applications to determine the legal age group of the user. This property is read-only and calculated based on ageGroup and consentProvidedForMinor properties. Allowed values: null, MinorWithOutParentalConsent, MinorWithParentalConsent, MinorNoParentalConsentRequired, NotAdult, and Adult. Refer to the legal age group property definitions for further information.
        # Returned only on $select.

        # licenseAssignmentStates 	licenseAssignmentState collection 	State of license assignments for this user. Also indicates licenses that are directly assigned or the user has inherited through group memberships. Read-only.
        # Returned only on $select.

        # mail 	String 	The SMTP address for the user, for example, jeff@contoso.onmicrosoft.com. Changes to this property update the user's proxyAddresses collection to include the value as an SMTP address. This property can't contain accent characters.
        # NOTE: We don't recommend updating this property for Azure AD B2C user profiles. Use the otherMails property instead.
        # Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, endsWith, and eq on null values).

        # mailboxSettings 	mailboxSettings 	Settings for the primary mailbox of the signed-in user. You can get or update settings for sending automatic replies to incoming messages, locale, and time zone.
        # Returned only on $select.

        # mailNickname 	String 	The mail alias for the user. This property must be specified when a user is created. Maximum length is 64 characters.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # mobilePhone 	String 	The primary cellular telephone number for the user. Read-only for users synced from the on-premises directory. Maximum length is 64 characters.
        # Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values) and $search.

        # mySite 	String 	The URL for the user's site.
        # Returned only on $select.

        # officeLocation 	String 	The office location in the user's place of business.
        # Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # onPremisesDistinguishedName 	String 	Contains the on-premises Active Directory distinguished name or DN. The property is only populated for customers who are synchronizing their on-premises directory to Microsoft Entra ID via Microsoft Entra Connect. Read-only.
        # Returned only on $select.

        # onPremisesDomainName 	String 	Contains the on-premises domainFQDN, also called dnsDomainName synchronized from the on-premises directory. The property is only populated for customers who are synchronizing their on-premises directory to Microsoft Entra ID via Microsoft Entra Connect. Read-only.
        # Returned only on $select.

        # onPremisesExtensionAttributes 	onPremisesExtensionAttributes 	Contains extensionAttributes1-15 for the user. These extension attributes are also known as Exchange custom attributes 1-15.
        # For an onPremisesSyncEnabled user, the source of authority for this set of properties is the on-premises and is read-only.
        # For a cloud-only user (where onPremisesSyncEnabled is false), these properties can be set during the creation or update of a user object.
        # For a cloud-only user previously synced from on-premises Active Directory, these properties are read-only in Microsoft Graph but can be fully managed through the Exchange Admin Center or the Exchange Online V2 module in PowerShell.
        # Returned only on $select. Supports $filter (eq, ne, not, in).

        # onPremisesImmutableId 	String 	This property is used to associate an on-premises Active Directory user account to their Microsoft Entra user object. This property must be specified when creating a new user account in the Graph if you're using a federated domain for the user's userPrincipalName (UPN) property. NOTE: The $ and _ characters can't be used when specifying this property.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in)..

        # onPremisesLastSyncDateTime 	DateTimeOffset 	Indicates the last time at which the object was synced with the on-premises directory; for example: 2013-02-16T03:04:54Z. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Read-only.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in).

        # onPremisesProvisioningErrors 	onPremisesProvisioningError collection 	Errors when using Microsoft synchronization product during provisioning.
        # Returned only on $select. Supports $filter (eq, not, ge, le).

        # onPremisesSamAccountName 	String 	Contains the on-premises samAccountName synchronized from the on-premises directory. The property is only populated for customers who are synchronizing their on-premises directory to Microsoft Entra ID via Microsoft Entra Connect. Read-only.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith).

        # onPremisesSecurityIdentifier 	String 	Contains the on-premises security identifier (SID) for the user that was synchronized from on-premises to the cloud. Read-only.
        # Returned only on $select. Supports $filter (eq including on null values).

        # onPremisesSyncEnabled 	Boolean 	true if this user object is currently being synced from an on-premises Active Directory (AD); otherwise the user isn't being synced and can be managed in Microsoft Entra ID. Read-only.
        # Returned only on $select. Supports $filter (eq, ne, not, in, and eq on null values).

        # onPremisesUserPrincipalName 	String 	Contains the on-premises userPrincipalName synchronized from the on-premises directory. The property is only populated for customers who are synchronizing their on-premises directory to Microsoft Entra ID via Microsoft Entra Connect. Read-only.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith).

        # otherMails 	String collection 	A list of additional email addresses for the user; for example: ["bob@contoso.com", "Robert@fabrikam.com"].
        # NOTE: This property can't contain accent characters.
        # Returned only on $select. Supports $filter (eq, not, ge, le, in, startsWith, endsWith, /$count eq 0, /$count ne 0).

        # passwordPolicies 	String 	Specifies password policies for the user. This value is an enumeration with one possible value being DisableStrongPassword, which allows weaker passwords than the default policy to be specified. DisablePasswordExpiration can also be specified. The two may be specified together; for example: DisablePasswordExpiration, DisableStrongPassword.
        # Returned only on $select. For more information on the default password policies, see Microsoft Entra password policies. Supports $filter (ne, not, and eq on null values).

        # passwordProfile 	passwordProfile 	Specifies the password profile for the user. The profile contains the user's password. This property is required when a user is created. The password in the profile must satisfy minimum requirements as specified by the passwordPolicies property. By default, a strong password is required.
        # Returned only on $select. Supports $filter (eq, ne, not, in, and eq on null values).

        # pastProjects 	String collection 	A list for the user to enumerate their past projects.
        # Returned only on $select.

        # postalCode 	String 	The postal code for the user's postal address. The postal code is specific to the user's country/region. In the United States of America, this attribute contains the ZIP code. Maximum length is 40 characters.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # preferredDataLocation 	String 	The preferred data location for the user. For more information, see OneDrive Online Multi-Geo.

        # preferredLanguage 	String 	The preferred language for the user. The preferred language format is based on RFC 4646. The name is a combination of an ISO 639 two-letter lowercase culture code associated with the language and an ISO 3166 two-letter uppercase subculture code associated with the country or region. Example: "en-US", or "es-ES".
        # Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)

        # preferredName 	String 	The preferred name for the user. Not Supported. This attribute returns an empty string.
        # Returned only on $select.

        # provisionedPlans 	provisionedPlan collection 	The plans that are provisioned for the user. Read-only. Not nullable.
        # Returned only on $select. Supports $filter (eq, not, ge, le).

        # proxyAddresses 	String collection 	For example: ["SMTP: bob@contoso.com", "smtp: bob@sales.contoso.com"]. Changes to the mail property will also update this collection to include the value as an SMTP address. For more information, see mail and proxyAddresses properties. The proxy address prefixed with SMTP (capitalized) is the primary proxy address while those prefixed with smtp are the secondary proxy addresses. For Azure AD B2C accounts, this property has a limit of 10 unique addresses. Read-only in Microsoft Graph; you can update this property only through the Microsoft 365 admin center. Not nullable.
        # Returned only on $select. Supports $filter (eq, not, ge, le, startsWith, endsWith, /$count eq 0, /$count ne 0).

        # refreshTokensValidFromDateTime 	DateTimeOffset 	Any refresh tokens or sessions tokens (session cookies) issued before this time are invalid, and applications get an error when using an invalid refresh or sessions token to acquire a delegated access token (to access APIs such as Microsoft Graph). If this happens, the application needs to acquire a new refresh token by requesting the authorized endpoint.
        # Returned only on $select. Read-only.

        # responsibilities 	String collection 	A list for the user to enumerate their responsibilities.
        # Returned only on $select.

        # serviceProvisioningErrors 	serviceProvisioningError collection 	Errors published by a federated service describing a non-transient, service-specific error regarding the properties or link from a user object .
        # Supports $filter (eq, not, for isResolved and serviceInstance).

        # schools 	String collection 	A list for the user to enumerate the schools they have attended.
        # Returned only on $select.

        # securityIdentifier 	String 	Security identifier (SID) of the user, used in Windows scenarios.
        # Read-only. Returned by default.
        # Supports $select and $filter (eq, not, ge, le, startsWith).

        # showInAddressList 	Boolean 	Do not use in Microsoft Graph. Manage this property through the Microsoft 365 admin center instead. Represents whether the user should be included in the Outlook global address list. See Known issue.

        # signInActivity 	signInActivity 	Get the last signed-in date and request ID of the sign-in for a given user. Read-only.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le) but not with any other filterable properties.
        # Note:
        # Details for this property require a Microsoft Entra ID P1 or P2 license and the AuditLog.Read.All permission.
        # This property is not returned for a user who has never signed in or last signed in before April 2020.

        # signInSessionsValidFromDateTime 	DateTimeOffset 	Any refresh tokens or sessions tokens (session cookies) issued before this time are invalid, and applications get an error when using an invalid refresh or sessions token to acquire a delegated access token (to access APIs such as Microsoft Graph). If this happens, the application needs to acquire a new refresh token by requesting the authorized endpoint. Read-only. Use revokeSignInSessions to reset.
        # Returned only on $select.

        # skills 	String collection 	A list for the user to enumerate their skills.
        # Returned only on $select.

        # state 	String 	The state or province in the user's address. Maximum length is 128 characters.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # streetAddress 	String 	The street address of the user's place of business. Maximum length is 1024 characters.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # surname 	String 	The user's surname (family name or last name). Maximum length is 64 characters.
        # Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # usageLocation 	String 	A two-letter country code (ISO standard 3166). Required for users that are assigned licenses due to legal requirements to check for availability of services in countries. Examples include: US, JP, and GB. Not nullable.
        # Returned only on $select. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values).

        # userPrincipalName 	String 	The user principal name (UPN) of the user. The UPN is an Internet-style sign-in name for the user based on the Internet standard RFC 822. By convention, this should map to the user's email name. The general format is alias@domain, where the domain must be present in the tenant's collection of verified domains. This property is required when a user is created. The verified domains for the tenant can be accessed from the verifiedDomains property of organization.
        # NOTE: This property can't contain accent characters. Only the following characters are allowed A - Z, a - z, 0 - 9, ' . - _ ! # ^ ~. For the complete list of allowed characters, see username policies.
        # Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, endsWith) and $orderby.

        # userType 	String 	A string value that can be used to classify user types in your directory, such as Member and Guest.
        # Returned only on $select. Supports $filter (eq, ne, not, in, and eq on null values). NOTE: For more information about the permissions for member and guest users, see What
        class User
          # TODO: Add support for all the fields listed above
          attr_accessor :business_phones, :display_name, :given_name, :job_title, :mail, :mobile_phone, :office_location, :preferred_language, :surname, :user_principal_name, :id

          def initialize(params = {})
            @business_phones = params[:business_phones]
            @display_name = params[:display_name]
            @given_name = params[:given_name]
            @job_title = params[:job_title]
            @mail = params[:mail]
            @mobile_phone = params[:mobile_phone]
            @office_location = params[:office_location]
            @preferred_language = params[:preferred_language]
            @surname = params[:surname]
            @user_principal_name = params[:user_principal_name]
            @id = params[:id]
          end
        end
      end
    end
  end
end
