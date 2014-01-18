# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.15-r1.ebuild,v 1.2 2014/01/18 05:07:32 vapier Exp $

EAPI="4"

inherit eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz
	mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="nls pcre"

RDEPEND="nls? ( virtual/libintl )
	pcre? ( >=dev-libs/libpcre-7.8-r1 )
	virtual/libiconv"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )

src_prepare() {
	EPATCH_OPTS="-Z" \
	epatch "${FILESDIR}/${P}-fix_pattern_matching.patch" \
		"${FILESDIR}/${P}-fix_pcre_abort_regression.patch" \
		"${FILESDIR}/${P}-avoid_maintainer_mode.patch"

	chmod a+x "${S}"/tests/{backslash-s-and-repetition-operators,pcre-invalid-utf8-input} \
		|| die
}

src_configure() {
	econf \
		--bindir="${EPREFIX}"/bin \
		$(use_enable nls) \
		$(use_enable pcre perl-regexp)
}
