# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rails_autolink/rails_autolink-1.0.9.ebuild,v 1.2 2013/03/03 12:48:35 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="This is an extraction of the auto_link method from rails."
HOMEPAGE="http://github.com/tenderlove/rails_autolink"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RUBY_PATCHES=( ${P}-fixes.patch )

ruby_add_bdepend "test? ( dev-ruby/minitest )"

ruby_add_rdepend ">=dev-ruby/rails-3.1"

each_ruby_prepare() {
	case ${RUBY} in
		*ruby18)
			sed -e '/auto_link_with_block_with_html/,/^  end/ s:^:#:' \
				-e '/auto_link_should_sanitize_input_with_sanitize_options/,/^  end/ s:^:#:' \
				-e '/auto_link_already_linked/,/^  end/ s:^:#:' \
				-i test/test_rails_autolink.rb || die
			;;
		*)
			;;
	esac
}

each_ruby_test() {
	${RUBY} -Ilib test/test_*.rb || die "tests failed"
}
