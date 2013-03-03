# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ANSITerminal/ANSITerminal-0.6.ebuild,v 1.4 2013/03/03 11:32:18 aballier Exp $

EAPI=5

OASIS_BUILD_DOCS=1

inherit oasis eutils

DESCRIPTION="Module which offers basic control of ANSI compliant terminals"
HOMEPAGE="http://forge.ocamlcore.org/projects/ansiterminal/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/610/${P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${P}-rebootstrap.patch.bz2"
LICENSE="LGPL-3-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
DEPEND=""
RDEPEND="${DEPEND}"
IUSE=""

DOCS=( "README.txt" "AUTHORS.txt" )

src_prepare() {
	epatch "${WORKDIR}/${P}-rebootstrap.patch"
}
