# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/calcurse/calcurse-3.1.2.ebuild,v 1.1 2013/01/08 15:46:15 jer Exp $

EAPI=4
inherit eutils

DESCRIPTION="a text-based personal organizer"
HOMEPAGE="http://calcurse.org"
SRC_URI="http://calcurse.org/files/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
CC_LINGUAS="de en es fr nl pt_BR ru"
for lingua in ${CC_LINGUAS}; do
	IUSE+=" linguas_${lingua}"
done

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	test? ( sys-libs/libfaketime )"

DOCS=( AUTHORS NEWS README TODO )
