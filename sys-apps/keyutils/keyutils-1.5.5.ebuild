# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/keyutils/keyutils-1.5.5.ebuild,v 1.9 2012/07/01 18:21:34 armin76 Exp $

EAPI="3"

inherit multilib eutils toolchain-funcs

DESCRIPTION="Linux Key Management Utilities"
HOMEPAGE="http://people.redhat.com/dhowells/keyutils/"
SRC_URI="http://people.redhat.com/dhowells/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux"
IUSE=""

DEPEND="!prefix? ( >=sys-kernel/linux-headers-2.6.11 )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.5-makefile-fixup.patch
	sed -i \
		-e '1iRPATH=' \
		-e '/^C.*FLAGS/s|:=|+=|' \
		-e 's:-Werror::' \
		-e '/^BUILDFOR/s:=.*:=:' \
		-e "/^LIBDIR/s:=.*:=/usr/$(get_libdir):" \
		-e '/^USRLIBDIR/s:=.*:=$(LIBDIR):' \
		Makefile || die

	# The lsb check is useless, so avoid spurious command not found messages.
	sed -i -e 's,lsb_release,:,' tests/prepare.inc.sh || die
	# All the test files are bash, but try to execute via `sh`.
	sed -i -r \
		-e 's:([[:space:]])sh([[:space:]]):\1bash\2:' \
		tests/{Makefile*,*.sh} || die
	find tests/ -name '*.sh' -exec sed -i '1s:/sh$:/bash:' {} +
	# Some tests call the kernel which calls userspace, but that will
	# run the install keyutils rather than the locally compiled one,
	# so disable round trip tests.
	rm -rf tests/keyctl/requesting/{bad-args,piped,valid}
}

src_configure() {
	tc-export CC
}

src_test() {
	# Execute the locally compiled code rather than the
	# older versions already installed in the system.
	LD_LIBRARY_PATH=${S} \
	PATH="${S}:${PATH}" \
	emake test || die
}

src_install() {
	emake DESTDIR="${ED}" install || die
	dodoc README
	gen_usr_ldscript -a keyutils
}
