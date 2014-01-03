# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lrzip/lrzip-0.616.ebuild,v 1.2 2014/01/03 03:26:08 mattst88 Exp $

EAPI=5

DESCRIPTION="Long Range ZIP or Lzma RZIP optimized for compressing large files"
HOMEPAGE="http://ck.kolivas.org/apps/lrzip/README"
SRC_URI="http://ck.kolivas.org/apps/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/lzo
	 app-arch/bzip2
	 sys-libs/zlib"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	virtual/perl-PodParser"

src_configure() {
	econf --docdir="/usr/share/doc/${P}"
}

src_install() {
	default
	rm "${D}/usr/share/doc/${P}/COPYING"
}
