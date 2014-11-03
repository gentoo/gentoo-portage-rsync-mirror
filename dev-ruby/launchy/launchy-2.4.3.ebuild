# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/launchy/launchy-2.4.3.ebuild,v 1.1 2014/11/03 10:30:49 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="README.md HISTORY.md"

inherit ruby-fakegem

DESCRIPTION="Helper class for launching cross-platform applications"
HOMEPAGE="http://copiousfreetime.rubyforge.org/launchy/"

LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/addressable-2.3"

ruby_add_bdepend "test? ( >=dev-ruby/minitest-5.0:5 )"

# This test is expected to fail on linux, drop it
RUBY_PATCHES=( "${FILESDIR}"/${PN}-2.4.2-drop-failing-test.patch )

all_ruby_prepare() {
	sed -i -e "/[Ss]implecov/d" spec/spec_helper.rb || die

	# Avoid tests depending on the current user's desktop environment.
	sed -e '/returns NotFound if it cannot determine/askip "gentoo"' \
		-i spec/detect/nix_desktop_environment_spec.rb || die
	sed -e '/asssumes we open a local file if we have an exception/askip "gentoo"' \
		-i spec/launchy_spec.rb || die
}
