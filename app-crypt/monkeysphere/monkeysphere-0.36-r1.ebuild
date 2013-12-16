# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/monkeysphere/monkeysphere-0.36-r1.ebuild,v 1.1 2013/12/16 11:26:32 tomwij Exp $

EAPI="5"

inherit eutils user

DESCRIPTION="Leverage the OpenPGP web of trust for OpenSSH and Web authentication"
HOMEPAGE="http://web.monkeysphere.info/"
SRC_URI="http://archive.${PN}.info/debian/pool/${PN}/${PN::1}/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# Tests do weird things with network and fail OOTB.
RESTRICT="test"

RDEPEND="
	app-crypt/gnupg
	app-misc/lockfile-progs
	dev-perl/Crypt-OpenSSL-RSA
	dev-perl/Digest-SHA1
	|| ( net-analyzer/netcat net-misc/socat )"
DEPEND="${RDEPEND}
	test? ( net-misc/socat )"

pkg_setup()
{
	einfo "Creating named group and user"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_prepare()
{
	epatch "${FILESDIR}/${P}_default_shell.patch"
	epatch "${FILESDIR}/${P}_non_default_port.patch"
	epatch "${FILESDIR}/${P}_userid_empty_line.patch"

	sed -i "s#share/doc/${PN}#share/doc/${PF}#" Makefile || die
}

src_install()
{
	default

	dodir /var/lib/${PN}
	fowners root:${PN} /var/lib/${PN}
	fperms 751 /var/lib/${PN}
}

pkg_postinst()
{
	${PN}-authentication setup || die
}
