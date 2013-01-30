# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/nsd/nsd-4.0.0_beta3.ebuild,v 1.1 2013/01/30 10:43:01 wschlich Exp $

EAPI=4

inherit user

DESCRIPTION="An authoritative only, high performance, open source name server"
HOMEPAGE="http://www.nlnetlabs.nl/projects/nsd"
# version voodoo needed only for non-release tarballs: 4.0.0_rc1 => 4.0.0rc1
MY_PV=${PV/_rc/rc}
MY_PV=${PV/_beta/b}
MY_P=${PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"
SRC_URI="http://www.nlnetlabs.nl/downloads/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bind8-stats ipv6 libevent minimal-responses mmap +nsec3 ratelimit root-server runtime-checks ssl"

RDEPEND="
	dev-libs/openssl
	virtual/yacc
	libevent? ( dev-libs/libevent )
	ssl? ( dev-libs/openssl )
"
DEPEND="
	${RDEPEND}
	sys-devel/flex
"

pkg_setup() {
	enewgroup nsd
	enewuser nsd -1 -1 -1 nsd
}

src_configure() {
	econf \
		--enable-largefile \
		--with-dbfile="${EPREFIX}"/var/db/nsd/nsd.db \
		--with-logfile="${EPREFIX}"/var/log/nsd.log \
		--with-pidfile="${EPREFIX}"/run/nsd/nsd.pid \
		--with-xfrdir="${EPREFIX}"/var/db/nsd \
		--with-xfrdfile="${EPREFIX}"/var/db/nsd/xfrd.db \
		$(use_enable bind8-stats) \
		$(use_enable ipv6) \
		$(use_enable minimal-responses) \
		$(use_enable mmap) \
		$(use_enable nsec3) \
		$(use_enable ratelimit) \
		$(use_enable root-server) \
		$(use_enable runtime-checks checking) \
		$(use_with libevent) \
		$(use_with ssl)
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc doc/{ChangeLog,CREDITS,NSD-4-features,NSD-FOR-BIND-USERS,README,RELNOTES,REQUIREMENTS}

	newinitd "${FILESDIR}"/nsd.initd nsd

	# database directory, writable by nsd for zone updates and transfers
	dodir /var/db/nsd
	fowners nsd:nsd /var/db/nsd
	fperms 750 /var/db/nsd

	# remove the /run directory that usually resides on tmpfs and is
	# being taken care of by the nsd init script anyway (checkpath)
	rm -rf "${D}"/run || die "Failed to remove /run"
}
