# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pnp4nagios/pnp4nagios-0.6.14-r1.ebuild,v 1.1 2012/06/25 19:45:21 prometheanfire Exp $

EAPI="2"

inherit depend.apache eutils

DESCRIPTION="A performance data analyzer for nagios"
HOMEPAGE="http://www.pnp4nagios.org"

SRC_URI="mirror://sourceforge/${PN}/PNP-0.6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="dev-lang/php[json,simplexml,zlib,xml,filter]
	>=dev-lang/php-5.3
	>=net-analyzer/rrdtool-1.2
	|| ( net-analyzer/nagios-core net-analyzer/icinga )"
RDEPEND="${DEPEND}
	virtual/perl-Getopt-Long
	virtual/perl-Time-HiRes
	media-fonts/dejavu
	apache2? ( www-servers/apache[apache2_modules_rewrite] )"

want_apache2

pkg_setup() {
	depend.apache_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_configure() {
	econf \
		--sysconfdir=/etc/pnp \
		--datarootdir=/usr/share/pnp \
		--mandir=/usr/share/man \
		--with-perfdata-dir=/var/nagios/perfdata \
		--with-perfdata-spool-dir=/var/spool/pnp
}

src_compile() {
	emake all || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install install-config || die "emake install failed"
	doinitd "${FILESDIR}/npcd"
	rm "${D}/usr/share/pnp/install.php"

	if use apache2 ; then
		insinto "${APACHE_MODULES_CONFDIR}"
		doins "${FILESDIR}"/98_pnp4nagios.conf
	fi
}

pkg_postinst() {
	elog "Please make sure to enable URL rewriting in Apache or any other"
	elog "webserver you're using, to get pnp4nagios running!"
}
