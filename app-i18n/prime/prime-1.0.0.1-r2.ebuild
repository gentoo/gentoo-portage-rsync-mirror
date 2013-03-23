# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-1.0.0.1-r2.ebuild,v 1.6 2013/03/23 09:56:03 ago Exp $

EAPI="3"
# don't work with ruby19
# jruby: sary-ruby issue
# rbx: sary-ruby issue
USE_RUBY="ruby18 ree18"
inherit autotools eutils ruby-ng

DESCRIPTION="Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 x86"
IUSE=""

ruby_add_bdepend "virtual/rubygems"
ruby_add_rdepend ">=app-dicts/prime-dict-1.0.0
	>=dev-libs/suikyo-2.1.0
	dev-ruby/ruby-progressbar
	dev-ruby/sary-ruby"

S="${WORKDIR}/${P/_/-}"

all_ruby_prepare() {
	epatch \
		"${FILESDIR}/${P}-parallel.patch" \
		"${FILESDIR}/${P}-libdir.patch" \
		"${FILESDIR}/${P}-require.patch"
	# eautoreconf
}

each_ruby_prepare() {
	sed -i -e "s:ruby -r:${RUBY} -r:" acinclude.m4 || die
	sed -i -e "s:ruby -e:${RUBY} -e:" src/Makefile.am || die
	eautoreconf
}

each_ruby_configure() {
	econf \
		--with-prime-docdir=/usr/share/doc/${PF}/html \
		--with-rubydir=$(ruby_rbconfig_value 'sitelibdir') || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_install() {
	emake DESTDIR="${D}" install install-etc || die
}

all_ruby_install() {
	dodoc AUTHORS ChangeLog NEWS README TODO || die
	dohtml -r doc/* || die
}
