# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clashscore-db/clashscore-db-3.17.ebuild,v 1.6 2012/06/13 06:52:07 jdhore Exp $

EAPI=4

DESCRIPTION="Clashscore-db for clashlist"
HOMEPAGE="http://kinemage.biochem.duke.edu/"
SRC_URI="mirror://gentoo/molprobity-${PV}.tgz"

SLOT="0"
LICENSE="richardson"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}"

src_install() {
	insinto /usr/share/clashscore
	doins molprobity3/lib/clashscore.db.tab
}
