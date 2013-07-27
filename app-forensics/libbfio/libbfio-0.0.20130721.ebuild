# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/libbfio/libbfio-0.0.20130721.ebuild,v 1.1 2013/07/27 00:50:54 zerochaos Exp $

EAPI=5

inherit versionator

MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library for providing a basic file input/output abstraction layer."
HOMEPAGE="http://code.google.com/p/libbfio/"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_configure() {
	econf $(use_enable unicode wide-character-type)
}
