# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/jekyll/jekyll-1.5.1.ebuild,v 1.3 2014/08/15 14:59:15 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

inherit ruby-fakegem

RUBY_FAKEGEM_EXTRADOC="CONTRIBUTING.markdown README.markdown History.markdown"
RUBY_FAKEGEM_EXTRAINSTALL="features"

DESCRIPTION="A simple, blog aware, static site generator"
HOMEPAGE="http://jekyllrb.com http://github.com/mojombo/jekyll"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_rdepend "dev-ruby/classifier
	dev-ruby/colorator
	<dev-ruby/commander-4.2
	=dev-ruby/liquid-2.5*
	>=dev-ruby/listen-1.3
	=dev-ruby/maruku-0.7.0
	dev-ruby/pygments_rb
	dev-ruby/redcarpet
	=dev-ruby/yajl-ruby-1.1*
	>=dev-ruby/safe_yaml-1
	dev-ruby/toml"

ruby_add_bdepend "test? (
		dev-ruby/activesupport:3.2
		>=dev-ruby/kramdown-1.2
		dev-ruby/launchy
		dev-ruby/mime-types
		<dev-ruby/rdiscount-2
		dev-ruby/redcloth
		dev-ruby/rr
		>=dev-ruby/shoulda-3 )"

all_ruby_prepare() {
	sed -i -e "/simplecov/,/Coveralls/d" test/helper.rb || die
}
