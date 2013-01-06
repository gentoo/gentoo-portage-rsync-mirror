# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/osptoolkit/osptoolkit-3.3.6-r1.ebuild,v 1.2 2009/04/14 09:57:59 armin76 Exp $

EAPI="2"

inherit eutils

DESCRIPTION="OSP (Open Settlement Protocol) library"
HOMEPAGE="http://www.transnexus.com/"
SRC_URI="http://www.transnexus.com/OSP%20Toolkit/Toolkits%20for%20Download/OSPToolkit-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/TK-${PV//./_}-20060303

src_prepare() {
	# change lib dir to $(LIBDIR)
	# and use users CFLAGS, see bug #241034
	sed -i -e "s:\$(INSTALL_PATH)/lib:\$(INSTALL_PATH)/\$(LIBDIR):" \
		-e "s:CFLAGS\t= -O:CFLAGS\t+= :" \
		src/Makefile || die "patching src/Makefile failed"

	sed -i -e "/CFLAGS /d" enroll/Makefile \
		|| die "patching enroll/Makefile failed"

	sed -i -e "s/CFLAGS     = -g/CFLAGS +=/" test/Makefile \
		|| die "patching test/Makefile failed"
}

src_compile() {
	emake -C src build || die "emake libosp failed"
	emake -C enroll linux || die "emake enroll failed"
	emake -C test linux || die "emake test failed"
}

src_install() {
	dodir /usr/include /usr/$(get_libdir)

	emake -C src INSTALL_PATH="${D}"/usr LIBDIR=$(get_libdir) \
		install || die "make install failed"

	sed -i  -e "s:^\(OPENSSL_CONF\).*:\1=/etc/ssl/openssl.cnf:" \
		-e "s:^\(RANDFILE\).*:\1=/etc/ssl/.rnd:" \
		bin/enroll.sh || die "patching bin/enroll.sh failed"

	dosbin bin/enroll* || die "dosbin failed"
	newbin bin/test_app osp_test_app || die "newbin failed"

	dodoc *.txt || die "dodoc failed"

	insinto /usr/share/doc/${PF}
	doins bin/test.cfg || die "doins failed"
}

pkg_postinst() {
	elog "The OSP test application is located in ${ROOT}usr/bin/osp_test_app"
	elog "See ${ROOT}usr/share/doc/${PF}/test.cfg for a sample test.cfg for osp_test_app"
}
