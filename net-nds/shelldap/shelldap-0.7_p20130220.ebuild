# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/shelldap/shelldap-0.7_p20130220.ebuild,v 1.2 2014/08/10 20:53:36 slyfox Exp $

EAPI=5

REVISION="bf9d6fa1b1d4"

DESCRIPTION="A handy shell-like interface for browsing LDAP servers and editing their content"
HOMEPAGE="http://projects.martini.nu/shelldap/"
SRC_URI="http://code.martini.nu/shelldap/archive/${REVISION}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Algorithm-Diff
	dev-perl/perl-ldap
	dev-perl/TermReadKey
	dev-perl/Term-ReadLine-Gnu
	dev-perl/Term-Shell
	dev-perl/YAML-Syck
	virtual/perl-Digest-MD5"

S="${WORKDIR}/${PN}-${REVISION}"

src_compile() {
	pod2man --name "${PN}" < "${PN}" > "${PN}.1" || die 'creating manpage failed'
}

src_install() {
	doman "${PN}.1"
	dobin "${PN}"
}
