# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/tomoe/tomoe-0.6.0.ebuild,v 1.5 2012/05/03 19:24:32 jdhore Exp $

DESCRIPTION="Japanese handwriting recognition engine"
HOMEPAGE="http://tomoe.sourceforge.jp/"
SRC_URI="mirror://sourceforge/tomoe/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc hyperestraier mysql ruby subversion"

RDEPEND=">=dev-libs/glib-2.4
	ruby? ( dev-ruby/ruby-glib2 )
	hyperestraier? ( app-text/hyperestraier )
	subversion? (
		>=dev-libs/apr-1
		dev-vcs/subversion
	)
	mysql? ( dev-db/mysql )"
# python? ( dev-python/pygobject )
# unihan? ( app-dicts/unihan )

DEPEND="${DEPEND}
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

RESTRICT="test"

src_compile() {
	econf \
		$(use_with ruby) \
		$(use_enable doc gtk-doc) || die
#		$(use_with python) \
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS TODO
}
