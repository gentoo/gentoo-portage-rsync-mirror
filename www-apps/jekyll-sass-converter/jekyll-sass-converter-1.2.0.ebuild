# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/jekyll-sass-converter/jekyll-sass-converter-1.2.0.ebuild,v 1.1 2014/08/15 14:54:48 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md History.markdown"

inherit ruby-fakegem

DESCRIPTION="A basic Sass converter for Jekyll"
HOMEPAGE="https://github.com/jekyll/jekyll-sass-converter"
SRC_URI="https://github.com/jekyll/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/sass"
ruby_add_bdepend "test? ( >=www-apps/jekyll-2 )"

all_ruby_prepare() {
	rm Rakefile || die
	# Fix tests until rspec:3 is in tree.
	sed -i -e "s/truthy/true/" -e "s/falsey/false/" spec/scss_converter_spec.rb spec/sass_coverter_spec.rb || die
}
