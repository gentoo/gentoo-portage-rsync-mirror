# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/rss2email/rss2email-2.65.ebuild,v 1.4 2011/04/05 05:50:28 ulm Exp $

EAPI=2

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="A python script that converts RSS newsfeeds to email"
HOMEPAGE="http://www.allthingsrss.com/rss2email"
SRC_URI="mirror://debian/pool/main/r/rss2email/rss2email_${PV}.orig.tar.gz
	mirror://debian/pool/main/r/rss2email/rss2email_${PV}-1.diff.gz"
# debian has a packaged archive that we use instead of:
# http://rss2email.infogami.com/${P}.py
# http://www.aaronsw.com/2002/html2text/html2text-2.35.py

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-python/feedparser
	dev-lang/python"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${WORKDIR}"/rss2email_${PV}-1.diff

	epatch "${FILESDIR}"/${P}-r2e-chmod.patch
	epatch "${FILESDIR}"/${P}-X-rss-feed.patch
}

src_install() {
	insinto /usr/share/rss2email
	doins rss2email.py html2text.py config.py

	exeinto /usr/bin
	doexe r2e

	doman r2e.1
}
