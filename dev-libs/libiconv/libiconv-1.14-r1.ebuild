# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.14-r1.ebuild,v 1.4 2013/12/24 12:43:52 ago Exp $

EAPI="4"

inherit libtool toolchain-funcs multilib-minimal

DESCRIPTION="GNU charset conversion library for libc which doesn't implement it"
HOMEPAGE="http://www.gnu.org/software/libiconv/"
SRC_URI="mirror://gnu/libiconv/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 arm ~mips ppc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="+static-libs"

DEPEND="!sys-libs/glibc
	!sys-apps/man-pages"
RDEPEND="${DEPEND}"

src_prepare() {
	# Make sure that libtool support is updated to link "the linux way"
	# on FreeBSD.
	elibtoolize
}

multilib_src_configure() {
	# Disable NLS support because that creates a circular dependency
	# between libiconv and gettext
	ECONF_SOURCE="${S}" econf \
		--docdir="\$(datarootdir)/doc/${PF}/html" \
		--disable-nls \
		--enable-shared \
		$(use_enable static-libs static)
}

multilib_src_install() {
	default

	# Install in /lib as utils installed in /lib like gnutar
	# can depend on this
	[ "${ABI}" = "${DEFAULT_ABI}" ] && gen_usr_ldscript -a iconv charset
}
