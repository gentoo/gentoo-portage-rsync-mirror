# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/shelldap/shelldap-0.4.ebuild,v 1.1 2011/04/30 20:36:04 pva Exp $

EAPI=3

REVISION="d703cba056e3"

DESCRIPTION="A handy shell-like interface for browsing LDAP servers and editing their content."
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

S=${WORKDIR}/${PN}-${REVISION}

src_compile() {
	pod2man --name ${PN} < ${PN} > ${PN}.1 || die
}

src_install() {
	doman ${PN}.1 || die
	dobin ${PN} || die
}
