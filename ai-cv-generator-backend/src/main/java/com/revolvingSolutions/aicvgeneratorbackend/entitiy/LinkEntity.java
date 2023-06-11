package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name="link")
public class LinkEntity {
    @Id
    @GeneratedValue
    public Integer linkid;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "did", referencedColumnName = "detailsid")
    public DetailsEntity details;

    @Column(nullable = false)
    public String url;
}
