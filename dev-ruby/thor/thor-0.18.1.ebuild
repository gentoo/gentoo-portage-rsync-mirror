# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/thor/thor-0.18.1.ebuild,v 1.1 2013/09/01 06:05:57 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"
RUBY_FAKEGEM_BINWRAP="thor"

inherit ruby-fakegem

DESCRIPTION="A scripting framework that replaces rake and sake"
HOMEPAGE="http://whatisthor.com/"

SRC_URI="http://github.com/erikhuda/${PN}/archive/v${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="doc"

ruby_add_bdepend "
	test? (
		>=dev-ruby/fakeweb-1.3
		dev-ruby/childlabor
	)"

all_ruby_prepare() {
	# Remove rspec default options (as we might not have the last
	# rspec).
	rm .rspec || die

	# Remove Bundler
	#rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Thorfile || die

	# Remove mandatory coverage collection using simplecov which is not
	# packaged.
	sed -i -e '/require .simplecov/,/SimpleCov.start/ s:^:#:' spec/helper.rb || die
}

each_ruby_prepare() {
	# Skip two failing specs on thor. Our jruby 1.6 is too old to file
	# bugs against and the next thor version will no longer work with
	# this version altogether.
	case ${RUBY} in
		*jruby)
			sed -i -e '/works with glob characters in the path/,/end/ s:^:#:' \
				spec/actions/directory_spec.rb || die
			;;
	esac
}
