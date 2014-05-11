# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/compass/compass-0.12.6.ebuild,v 1.1 2014/05/11 22:23:10 vikraman Exp $

EAPI=5

USE_RUBY="ruby19"
RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_TASK_TEST="-Ilib test features"
RUBY_FAKEGEM_EXTRAINSTALL="frameworks"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Sass-based Stylesheet Framework"
HOMEPAGE="http://compass-style.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_bdepend "
	>=dev-ruby/sass-3.2.18
	>=dev-ruby/chunky_png-1.3
	>=dev-ruby/fssm-0.2.7
	test? (
		dev-ruby/mocha
		virtual/ruby-test-unit
		dev-ruby/css_parser
	)
"

all_ruby_prepare() {
	sed -e '/.*[Bb]undler.*/d' \
		-i Rakefile || die "sed failed"
	sed -e '/require \"mocha\/test_unit\"/d' \
		-i test/test_helper.rb || die "sed failed"
}
