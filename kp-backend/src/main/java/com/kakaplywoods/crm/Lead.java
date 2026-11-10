package com.kakaplywoods.crm;
import jakarta.persistence.*;import java.time.OffsetDateTime;import java.util.UUID;
@Entity @Table(name="leads") public class Lead {
 @Id @GeneratedValue(strategy=GenerationType.UUID) private UUID id;
 @Column(name="lead_code",nullable=false,unique=true) private String leadCode;
 @Column(nullable=false) private String name;@Column(nullable=false) private String phone;private String email;
 @Column(name="product_interest") private String productInterest;@Column(length=2000) private String message;
 @Column(nullable=false) private String source="WEBSITE";@Column(nullable=false) private String status="NEW";
 @Column(name="assigned_to") private String assignedTo;@Column(name="follow_up_at") private OffsetDateTime followUpAt;
 @Column(name="created_at",nullable=false) private OffsetDateTime createdAt=OffsetDateTime.now();@Column(name="updated_at",nullable=false) private OffsetDateTime updatedAt=OffsetDateTime.now();
 @PrePersist void onCreate(){if(leadCode==null)leadCode="KPL-"+UUID.randomUUID().toString().substring(0,8).toUpperCase();createdAt=OffsetDateTime.now();updatedAt=createdAt;}
 @PreUpdate void onUpdate(){updatedAt=OffsetDateTime.now();}
 public UUID getId(){return id;}public String getLeadCode(){return leadCode;}public String getName(){return name;}public void setName(String v){name=v;}public String getPhone(){return phone;}public void setPhone(String v){phone=v;}public String getEmail(){return email;}public void setEmail(String v){email=v;}public String getProductInterest(){return productInterest;}public void setProductInterest(String v){productInterest=v;}public String getMessage(){return message;}public void setMessage(String v){message=v;}public String getSource(){return source;}public void setSource(String v){source=v;}public String getStatus(){return status;}public void setStatus(String v){status=v;}public String getAssignedTo(){return assignedTo;}public void setAssignedTo(String v){assignedTo=v;}public OffsetDateTime getFollowUpAt(){return followUpAt;}public void setFollowUpAt(OffsetDateTime v){followUpAt=v;}public OffsetDateTime getCreatedAt(){return createdAt;}public OffsetDateTime getUpdatedAt(){return updatedAt;}
}
