# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libverto/libverto-0.2.6.ebuild,v 1.1 2014/06/16 09:55:22 eras Exp $

EAPI=5

inherit multilib-minimal

DESCRIPTION="Main event loop abstraction library"
HOMEPAGE="https://fedorahosted.org/libverto/"
SRC_URI="https://fedorahosted.org/releases/l/i/libverto/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd"
IUSE="glib +libev libevent tevent +threads static-libs"

# file collisions
DEPEND="!=app-crypt/mit-krb5-1.10.1-r0
	!=app-crypt/mit-krb5-1.10.1-r1
	!=app-crypt/mit-krb5-1.10.1-r2
	glib? ( >=dev-libs/glib-2.29[${MULTILIB_USEDEP}] )
	libev? ( >=dev-libs/libev-4.11[${MULTILIB_USEDEP}] )
	libevent? ( >=dev-libs/libevent-2.0[${MULTILIB_USEDEP}] )
	tevent? ( sys-libs/tevent[${MULTILIB_USEDEP}] )"

RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( glib libev libevent tevent ) "

src_prepare() {
	# known problem uptream with tevent write test.  tevent does not fire a
	# callback on error, but we explicitly test for this behaviour.  Do not run
	# tevent tests for now.
	sed -i -e 's/def HAVE_TEVENT/ 0/' tests/test.h || die
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" \
	econf \
		$(use_with glib) \
		$(use_with libev) \
		$(use_with libevent) \
		$(use_with tevent) \
		$(use_with threads pthread) \
		$(use_enable static-libs static)
}

multilib_src_install_all() {
	dodoc AUTHORS ChangeLog NEWS INSTALL README
	use static-libs || prune_libtool_files --all
}
