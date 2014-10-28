# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sass/sass-3.3.14-r1.ebuild,v 1.1 2014/10/28 18:22:04 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_EXTRAINSTALL="rails init.rb VERSION VERSION_NAME"

# Don't install binaries for compatibility with higher slot.
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem versionator

DESCRIPTION="An extension of CSS3, adding nested rules, variables, mixins, selector inheritance, and more"
HOMEPAGE="http://sass-lang.com/"
LICENSE="MIT"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
SLOT="$(get_version_component_range 1-2)"
IUSE=""

ruby_add_bdepend "doc? ( >=dev-ruby/yard-0.5.3 )"

ruby_add_rdepend ">=dev-ruby/listen-1.3.1 !!<dev-ruby/haml-3.1 !!<dev-ruby/sass-3.2.19-r1"

# tests could use `less` if we had it

all_ruby_prepare() {
	rm -rf vendor/listen || die

	# Don't require maruku as markdown provider but let yard decide.
	sed -i -e '/maruku/d' .yardopts || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Test fails on jruby for us, upstream can't
			# reproduce. Avoiding it since it only affects debug
			# information in the CSS file.
			# https://github.com/nex3/sass/issues/563
			sed -i -e '24s/filename_fn//' test/sass/plugin_test.rb || die
			sed -i -e '/test_random/,/^  end/ s:^:#:' test/sass/functions_test.rb || die
			;;
		*)
			;;
	esac
}

each_ruby_test() {
	RUBOCOP=false ${RUBY} -S rake test || die
}
