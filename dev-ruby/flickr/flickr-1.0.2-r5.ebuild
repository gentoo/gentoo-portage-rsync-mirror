# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flickr/flickr-1.0.2-r5.ebuild,v 1.5 2014/08/05 16:01:01 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 jruby"

# Tests require a flickr API key.
RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="An insanely easy interface to the Flickr photo-sharing service"
HOMEPAGE="http://rubyforge.org/projects/flickr/"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"

RUBY_S="${P}-gentoo"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/xml-simple"

all_ruby_prepare() {
	cd lib || die
	epatch "${FILESDIR}/${P}-fix.patch"
	epatch "${FILESDIR}/${P}-typo.patch"
}
