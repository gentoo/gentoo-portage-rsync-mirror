# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.21.8.ebuild,v 1.2 2014/12/22 14:32:52 polynomial-c Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-solaris"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/unrtf-0.21.8-automake-fix.patch
	epatch "${FILESDIR}"/${PN}-0.21.8-iconv-detection.patch
	eautoreconf
}
