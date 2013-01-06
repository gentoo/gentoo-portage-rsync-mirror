# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-plugin-esdip/iscan-plugin-esdip-1.0.0.5.ebuild,v 1.2 2012/11/03 20:47:27 flameeyes Exp $

EAPI=4

inherit rpm versionator multilib

MY_PV="$(get_version_component_range 1-3)"
MY_PVR="$(replace_version_separator 3 -)"

DESCRIPTION="Plugin for 'epkowa' backend for image manipulation."
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="
	x86? ( http://linux.avasys.jp/drivers/iscan-plugins/${PN}/${MY_PV}/${PN}-${MY_PVR}.ltdl7.i386.rpm )
	amd64? ( http://linux.avasys.jp/drivers/iscan-plugins/${PN}/${MY_PV}/${PN}-${MY_PVR}.ltdl7.x86_64.rpm )
"

LICENSE="AVASYS"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE=""

DEPEND=">=media-gfx/iscan-2.28.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PREBUILT="/opt/iscan/esci/*"

src_configure() { :; }
src_compile() { :; }

src_install() {
	dodoc usr/share/doc/*/*

	exeinto /usr/$(get_libdir)/iscan
	doexe usr/$(get_libdir)/iscan/*

	insinto /usr/share/iscan
	doins usr/share/iscan/*
}
