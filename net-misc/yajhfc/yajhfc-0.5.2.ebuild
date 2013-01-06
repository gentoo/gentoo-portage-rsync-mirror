# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/yajhfc/yajhfc-0.5.2.ebuild,v 1.1 2012/07/02 14:48:24 mattm Exp $

EAPI="3"

inherit eutils versionator java-pkg-opt-2

MY_P="${PN}-${PV}.jar"
MY_P="${MY_P/_/}"
MY_P="${MY_P/./_}"
MY_P="${MY_P/./_}"

DESCRIPTION="YajHFC - Yet another Java HylaFAX Plus Client"
HOMEPAGE="http://www.yajhfc.de/"
SRC_URI="http://download.yajhfc.de/releases/${MY_P}"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS=""

IUSE=""

COMMON_DEPEND=">=virtual/jdk-1.4"
RDEPEND="${COMMON_DEPEND} >=virtual/jre-1.4"
DEPEND="${COMMON_DEPEND} virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	exeinto /usr/bin/
	exeopts -m555
	echo "java -jar /usr/bin/${MY_P}" > ${WORKDIR}/h.h
	newexe "${WORKDIR}/h.h" "yajhfc" || die
	newexe "${DISTDIR}/${MY_P}" "${MY_P}" || die
}
