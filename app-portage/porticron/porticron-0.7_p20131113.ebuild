# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porticron/porticron-0.7_p20131113.ebuild,v 1.2 2014/11/12 20:31:56 sping Exp $

EAPI="5"

inherit vcs-snapshot

DESCRIPTION="cron script to sync portage and send update mails to root"
HOMEPAGE="https://github.com/gentoo/porticron"
SRC_URI="https://github.com/hollow/${PN}/tarball/df727fe -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="net-dns/bind-tools"
DEPEND=""

src_install() {
	dosbin bin/porticron
	insinto /etc
	doins etc/porticron.conf
}
