# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/typed-array/typed-array-0.1.2-r1.ebuild,v 1.3 2014/08/06 07:24:59 mrueg Exp $

EAPI=5

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

USE_RUBY="ruby19 ruby20 ruby21 jruby"

inherit ruby-fakegem
DESCRIPTION="Gem provides enforced-type functionality to Arrays"
HOMEPAGE="http://github.com/yaauie/typed-array"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_prepare() {
	# There is a trash...
	rm "${S}"/lib/typed-array/.DS_Store || die
}
