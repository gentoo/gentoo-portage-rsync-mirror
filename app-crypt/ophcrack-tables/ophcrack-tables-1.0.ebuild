# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ophcrack-tables/ophcrack-tables-1.0.ebuild,v 1.2 2009/10/31 00:38:46 ikelos Exp $

EAPI="1"

DESCRIPTION="Tables available for ophcrack"
HOMEPAGE="http://ophcrack.sourceforge.net/"
SRC_URI="xpfast? ( mirror://sourceforge/ophcrack/tables_xp_free_fast.zip )
		 xpsmall? ( mirror://sourceforge/ophcrack/tables_xp_free_small.zip )
		 vistafree? ( mirror://sourceforge/ophcrack/tables_vista_free.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="+xpfast xpsmall +vistafree"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	for i in ${A};
	do
		table=${i#tables_}
		table=${table%.zip}
		mkdir "${S}/${table}"
		cd "${S}/${table}"
		unpack "${i}"
	done
}

src_install() {
	dodir /usr/share/ophcrack/
	cp -r "${S}/*" "${D}/usr/share/ophcrack"
}
