# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ccs-tools/ccs-tools-1.6.8_p20100115.ebuild,v 1.1 2010/01/23 06:49:05 matsuu Exp $

EAPI="2"
inherit eutils multilib toolchain-funcs

MY_P="${P/_p/-}"
DESCRIPTION="TOMOYO Linux tools"
HOMEPAGE="http://tomoyo.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/tomoyo/30298/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

DEPEND="sys-libs/ncurses
	sys-libs/readline"
RDEPEND="${DEPEND}
	sys-apps/which"

S="${WORKDIR}/ccstools"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.6.8_p20090623-gentoo.patch"

	sed -i \
		-e "/^CC=/s:gcc:$(tc-getCC):" \
		-e "/^CFLAGS=/s:-O2:${CFLAGS}:" \
		-e "s:/usr/lib/:/usr/$(get_libdir)/:g" \
		Makefile || die

	sed -i \
		-e "s:/usr/lib/ccs:/usr/$(get_libdir)/ccs:g" \
		init_policy.sh tomoyo_init_policy.sh || die

	echo "CONFIG_PROTECT=\"/usr/$(get_libdir)/ccs/conf\"" > "${T}/50${PN}" || die
}

src_test() {
	cd "${S}/kernel_test"
	emake || die
	./testall.sh || die
}

src_install() {
	emake INSTALLDIR="${D}" install || die

	rm "${D}"/usr/$(get_libdir)/ccs/{COPYING.ccs,README.ccs,ccstools.conf} || die
	insinto /usr/$(get_libdir)/ccs/conf
	doins ccstools.conf || die
	dosym conf/ccstools.conf /usr/$(get_libdir)/ccs/ccstools.conf || die

	doenvd "${T}/50${PN}" || die

	dodoc README.ccs
}

pkg_postinst() {
	elog "Execute the following command to setup the initial policy configuration:"
	elog
	elog "emerge --config =${CATEGORY}/${PF}"
	elog
	elog "For more information, please visit the following."
	elog
	elog "For >=kernel-2.6.30:"
	elog "http://tomoyo.sourceforge.jp/en/2.2.x/"
	elog
	elog "For <kernel-2.6.30 + ccs-patch:"
	elog "http://tomoyo.sourceforge.jp/en/1.6.x/"
}

pkg_config() {
	/usr/$(get_libdir)/ccs/tomoyo_init_policy.sh
}
