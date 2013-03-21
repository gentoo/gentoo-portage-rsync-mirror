# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x2goserver/x2goserver-4.0.0.0.ebuild,v 1.3 2013/03/21 13:55:35 voyageur Exp $

EAPI=4
inherit eutils multilib toolchain-funcs user

DESCRIPTION="The X2Go server"
HOMEPAGE="http://www.x2go.org"
SRC_URI="http://code.x2go.org/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fuse postgres +sqlite"

REQUIRED_USE="|| ( postgres sqlite )"

# Requires man2html, only provided by sys-apps/man
DEPEND="sys-apps/man"
RDEPEND="dev-perl/Config-Simple
	media-fonts/font-cursor-misc
	media-fonts/font-misc-misc
	net-misc/nx
	virtual/ssh
	x11-apps/xauth
	fuse? ( sys-fs/sshfs-fuse )
	postgres? ( dev-perl/DBD-Pg )
	sqlite? ( dev-perl/DBD-SQLite )"

pkg_setup() {
	enewuser x2gouser -1 -1 /var/lib/x2go
	enewuser x2goprint -1 -1 /var/spool/x2goprint
}

src_prepare() {
	# Respect CC/LDFLAGS
	epatch "${FILESDIR}"/${P}-cc_ldflags.patch

	# Multilib clean
	sed -e "/^LIBDIR=/s/lib/$(get_libdir)/" -i */Makefile || die "multilib sed failed"
	# Use nxagent directly
	sed -i -e "/NX_TEMP=/s/x2goagent/nxagent/" x2goserver/bin/x2gostartagent || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install

	fowners root:x2goprint /usr/bin/x2goprint
	fperms 2755 /usr/bin/x2goprint
	dosym /usr/share/applications /etc/x2go/applications

	newinitd "${FILESDIR}"/${PN}.init x2gocleansessions
}

pkg_postinst() {
	if use sqlite ; then
		elog "To use sqlite and create the initial database, run:"
		elog " # x2godbadmin --createdb"
	fi
	if use postgres ; then
		elog "To use a PostgreSQL databse, more information is availabe here:"
		elog "http://www.x2go.org/doku.php/wiki:advanced:multi-node:x2goserver-pgsql"
	fi

	elog "For password authentication, you need to enable PasswordAuthentication"
	elog "in /etc/ssh/sshd_config (disabled by default in Gentoo)"
	elog "An init script was installed for x2gocleansessions"
}
