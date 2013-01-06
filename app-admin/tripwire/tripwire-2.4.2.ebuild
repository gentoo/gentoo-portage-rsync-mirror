# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tripwire/tripwire-2.4.2.ebuild,v 1.2 2012/04/25 16:07:04 jlec Exp $

EAPI="2"

inherit eutils flag-o-matic autotools

TW_VER=${PV}
DESCRIPTION="Open Source File Integrity Checker and IDS"
HOMEPAGE="http://www.tripwire.org/"
SRC_URI="mirror://sourceforge/tripwire/tripwire-${TW_VER}-src.tar.bz2
	mirror://gentoo/twpol.txt.gz
	mirror://gentoo/tripwire.gif"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="ssl static"

DEPEND="sys-devel/automake
	sys-devel/autoconf
	dev-util/patchutils
	ssl? ( dev-libs/openssl )"
RDEPEND="virtual/cron
	virtual/mta
	ssl? ( dev-libs/openssl )"

S="${WORKDIR}"/tripwire-${TW_VER}-src

src_prepare() {
	eautoreconf
}

src_configure() {
	# tripwire can be sensitive to compiler optimisation.
	# see #32613, #45823, and others.
	# 	-taviso@gentoo.org
	strip-flags
	append-flags -DCONFIG_DIR='"\"/etc/tripwire\""' -fno-strict-aliasing
	einfo "Done."
	chmod +x configure
	econf $(use_enable ssl openssl) $(use_enable static)
}

src_install() {
	dosbin "${S}"/bin/{siggen,tripwire,twadmin,twprint}
	doman "${S}"/man/man{4/*.4,5/*.5,8/*.8}
	dodir /etc/tripwire /var/lib/tripwire{,/report}
	keepdir /var/lib/tripwire{,/report}

	exeinto /etc/cron.daily
	doexe "${FILESDIR}"/tripwire.cron

	dodoc ChangeLog policy/policyguide.txt TRADEMARK \
		"${FILESDIR}"/tripwire.txt

	insinto /etc/tripwire
	doins "${WORKDIR}"/twpol.txt "${FILESDIR}"/twcfg.txt

	exeinto /etc/tripwire
	doexe "${FILESDIR}"/twinstall.sh

	fperms 755 /etc/tripwire/twinstall.sh /etc/cron.daily/tripwire.cron
}

pkg_postinst() {
	elog "After installing this package, you should run \"/etc/tripwire/twinstall.sh\""
	elog "to generate cryptographic keys, and \"tripwire --init\" to initialize the"
	elog "database Tripwire uses."
	elog
	elog "A quickstart guide is included with the documentation."
	elog
}
