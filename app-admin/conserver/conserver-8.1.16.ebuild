# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conserver/conserver-8.1.16.ebuild,v 1.6 2014/05/30 13:05:18 swift Exp $

inherit ssl-cert eutils pam

DESCRIPTION="Serial Console Manager"
HOMEPAGE="http://www.conserver.com/"
SRC_URI="ftp://ftp.conserver.com/conserver/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="pam ssl tcpd debug"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6g )
	pam? ( virtual/pam )
	tcpd? ( sys-apps/tcp-wrappers )
	debug? ( dev-libs/dmalloc )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply patch to prevent package from stripping binaries
	epatch "${FILESDIR}"/${PN}-prestrip.patch
}

src_compile() {
	econf \
		$(use_with ssl openssl) \
		$(use_with pam) \
		$(use_with tcpd libwrap) \
		$(use_with debug dmalloc) \
		--with-logfile=/var/log/conserver.log \
		--with-pidfile=/var/run/conserver.pid \
		--with-cffile=conserver/conserver.cf \
		--with-pwdfile=conserver/conserver.passwd \
		--with-master=localhost \
		--with-port=7782 || die "./configure failed"

	emake || die "compile failed"
}

src_install() {
	einstall exampledir="${D}"/usr/share/doc/${PF}/examples \
		|| die "problem with install"

	## create data directory
	dodir /var/consoles
	fowners daemon:daemon /var/consoles
	fperms 700 /var/consoles

	## add startup and sample config
	newinitd "${FILESDIR}"/conserver.initd conserver
	newconfd "${FILESDIR}"/conserver.confd conserver

	dodir /etc/conserver
	fperms 700 /etc/conserver
	insinto /etc/conserver
	newins "${S}"/conserver.cf/conserver.cf conserver.cf.sample
	newins "${S}"/conserver.cf/conserver.passwd conserver.passwd.sample

	## add docs
	dohtml conserver.html
	dodoc CHANGES FAQ PROTOCOL README TODO
	dodoc conserver/Sun-serial contrib/maketestcerts
	newdoc conserver.cf/conserver.cf conserver.cf.sample

	# Add pam config
	newpamd "${FILESDIR}"/conserver.pam-include.1 conserver
}

pkg_postinst() {
	# Add certs if SSL use flag is enabled
	if use ssl && [ ! -f "${ROOT}"/etc/ssl/conserver/conserver.key ]; then
		install_cert /etc/ssl/conserver/conserver
	fi
}
