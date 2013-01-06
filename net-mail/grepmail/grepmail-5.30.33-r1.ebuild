# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-5.30.33-r1.ebuild,v 1.4 2012/02/05 18:07:20 armin76 Exp $

inherit versionator perl-module

MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/grepmail/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="dev-perl/Inline
	dev-perl/TimeDate
	dev-perl/DateManip
	virtual/perl-Digest-MD5
	>=dev-perl/Mail-Mbox-MessageParser-1.40.01"
DEPEND="${RDEPEND}"

SRC_TEST="do"
PATCHES=( "${FILESDIR}"/5.30.33-fix_nonexistent_mailbox_test.patch
	"${FILESDIR}"/5.30.33-midnight.patch )
