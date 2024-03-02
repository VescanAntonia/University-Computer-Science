package com.example.citybreak.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "citybreak")

public class CityBreak {

    @Id
    private Long id;

    @Column(name="city")
    private String city;

    @Column(name="country")
    private String country;

    @Column(name="startDate")
    private String startDate;

    @Column(name="endDate")
    private String endDate;

    @Column(name="description")
    private String description;

    @Column(name="accommodation")
    private String accommodation;

    @Column(name="budget")
    private String budget;

}
