# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn-layout/prawn-layout-0.8.4-r2.ebuild,v 1.11 2014/10/26 14:07:03 graaff Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem versionator

DESCRIPTION="An extension to Prawn offering table support, grid layouts and other things"
HOMEPAGE="http://prawn.majesticseacreature.com/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

ruby_add_bdepend test "dev-ruby/test-spec dev-ruby/mocha"

ruby_add_rdepend "=dev-ruby/prawn-core-$(get_version_component_range 1-2)*"

all_ruby_prepare() {
	# Avoid obsolete rake tasks.
	sed -i -e 's:rake/rdoctask:rdoc/task:' \
		-e '/gempackagetask/ s:^:#:' \
		-e '/GemPackageTask/,/end/ s:^:#:' Rakefile || die
}

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
