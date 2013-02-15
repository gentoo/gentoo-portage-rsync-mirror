# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-fr/man-pages-fr-3.40.1.ebuild,v 1.1 2013/02/15 20:56:36 pinkbyte Exp $

EAPI=5

DESCRIPTION="A somewhat comprehensive collection of french Linux man pages"
HOMEPAGE="http://traduc.org/perkamon"
SRC_URI="http://alioth.debian.org/frs/download.php/3722/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="virtual/man"
DEPEND=""

S="${WORKDIR}/fr"

src_install() {
	dodoc README.fr
	doman -i18n=fr man*/*
}
