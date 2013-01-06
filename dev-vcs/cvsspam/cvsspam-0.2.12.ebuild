# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvsspam/cvsspam-0.2.12.ebuild,v 1.2 2010/06/22 18:44:07 arfrever Exp $

EAPI=2

inherit eutils

DESCRIPTION="Utility to send colored HTML CVS-mails"
HOMEPAGE="http://www.badgers-in-foil.co.uk/projects/cvsspam/"
SRC_URI="http://www.badgers-in-foil.co.uk/projects/cvsspam/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="subversion"

RDEPEND="dev-lang/ruby
	subversion? ( dev-vcs/subversion )"

src_prepare() {
	use subversion && epatch "${FILESDIR}/${P}-svn.patch"
}

src_install() {
	dobin collect_diffs.rb || die
	dobin cvsspam.rb || die
	dobin record_lastdir.rb || die
	insinto /etc/cvsspam || die
	doins cvsspam.conf || die

	dohtml cvsspam-doc.html
	dodoc CREDITS TODO cvsspam-doc.pdf
}
