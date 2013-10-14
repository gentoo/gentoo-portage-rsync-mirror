# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/base64/base64-2.3.7.ebuild,v 1.1 2013/10/14 17:06:44 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="A Base64 encoder written in java"
HOMEPAGE="http://iharder.sourceforge.net/current/java/base64/"
SRC_URI="mirror://sourceforge/iharder/${PN}/${MY_PV}/${PN^}-v${PV}.zip -> ${P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN^}-v${PV}"
