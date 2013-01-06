# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x2goserver/x2goserver-3.1.0.1.ebuild,v 1.2 2012/07/10 13:56:11 voyageur Exp $

EAPI=4
inherit eutils multilib user

DESCRIPTION="The X2Go server"
HOMEPAGE="http://www.x2go.org"
SRC_URI="http://code.x2go.org/releases/source/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fuse postgres +sqlite"

REQUIRED_USE="|| ( postgres sqlite )"

DEPEND=""
RDEPEND="dev-perl/Config-Simple
	net-misc/nx
	virtual/ssh
	fuse? ( sys-fs/sshfs-fuse )
	postgres? ( dev-perl/DBD-Pg )
	sqlite? ( dev-perl/DBD-SQLite )"

S=${WORKDIR}/${P/-/_}

pkg_setup() {
	enewuser x2gouser -1 -1 /var/lib/x2go
	enewuser x2goprint -1 -1 /var/spool/x2goprint
}

src_prepare() {
	# Multilib clean
	sed -e "/^LIBDIR=/s/lib/$(get_libdir)/" -i */Makefile || die "multilib sed failed"
	# Use nxagent directly
	sed -i -e "s/x2goagent/nxagent/" x2goserver/bin/x2gostartagent || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install

	fowners root:x2goprint /usr/bin/x2goprint
	fperms 2755 /usr/bin/x2goprint

	newinitd "${FILESDIR}"/${PN}.init x2gocleansessions
}

pkg_postinst() {
	if use sqlite ; then
		elog "To create the initial database, run:"
		elog " # x2godbadmin --createdb"
	fi
	elog "For password authentication, you need to enable PasswordAuthentication"
	elog "in /etc/ssh/sshd_config (disabled by default in Gentoo)"
	elog "An init script was installed for x2gocleansessions"
}
