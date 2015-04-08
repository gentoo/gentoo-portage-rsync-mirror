# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/omniORB/omniORB-4.1.4-r1.ebuild,v 1.7 2012/02/05 01:53:54 floppym Exp $

EAPI="3"

# 2.5 is problematic due to bug #261330
PYTHON_DEPEND="2:2.6"

inherit python eutils multilib

DESCRIPTION="A robust, high-performance CORBA 2 ORB"
SRC_URI="mirror://sourceforge/omniorb/${P}.tar.gz"
HOMEPAGE="http://omniorb.sourceforge.net/"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="doc ssl"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# respect ldflags, bug #284191
	epatch "${FILESDIR}"/ldflags.patch \
		"${FILESDIR}"/${P}-openssl-1.patch

	sed -i -e 's/^CXXDEBUGFLAGS.*/CXXDEBUGFLAGS = $(OPTCXXFLAGS)/' \
		-e 's/^CDEBUGFLAGS.*/CDEBUGFLAGS = $(OPTCFLAGS)/' \
		mk/beforeauto.mk.in \
		mk/platforms/i586_linux_2.0*.mk || die "sed failed"
}

src_configure() {
	mkdir build && cd build || die

	local MY_CONF="--prefix=/usr --with-omniORB-config=/etc/omniorb/omniORB.cfg \
		--with-omniNames-logdir=/var/log/omniORB --libdir=/usr/$(get_libdir)"

	use ssl && MY_CONF="${MY_CONF} --with-openssl=/usr"

	PYTHON="$(PYTHON -a)" ECONF_SOURCE=".." econf ${MY_CONF}
}

src_compile() {
	cd build
	emake OPTCFLAGS="${CFLAGS}" OPTCXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	cd build
	emake DESTDIR="${D}" install || die "emake install failed"
	# this looks redundant
	rm "${D}/usr/bin/omniidlrun.py" || die

	cd "${S}"
	dodoc COPYING* CREDITS README* ReleaseNotes* || die

	if use doc; then
		dohtml doc/*.html || die
		dohtml -r doc/omniORB || die
		docinto print
		dodoc doc/*.pdf || die
	fi

	dodir /etc/env.d/
	cat <<- EOF > "${T}/90omniORB"
		PATH="/usr/share/omniORB/bin/scripts"
		OMNIORB_CONFIG="/etc/omniorb/omniORB.cfg"
	EOF
	doenvd "${T}/90omniORB" || die
	doinitd "${FILESDIR}"/omniNames || die

	cp "sample.cfg" "${T}/omniORB.cfg" || die
	cat <<- EOF >> "${T}/omniORB.cfg"
		# resolve the omniNames running on localhost
		InitRef = NameService=corbaname::localhost
	EOF
	dodir /etc/omniorb
	insinto /etc/omniorb
	doins "${T}/omniORB.cfg" || die

	keepdir /var/log/omniORB
}

pkg_postinst() {
	elog "Since 4.1.2, the omniORB init script has been renamed to omniNames for clarity."
	python_mod_optimize omniidl omniidl_be
}

pkg_postrm() {
	python_mod_cleanup omniidl omniidl_be
}
