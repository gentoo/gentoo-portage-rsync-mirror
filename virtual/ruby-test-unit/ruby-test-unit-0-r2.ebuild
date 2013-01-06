# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ruby-test-unit/ruby-test-unit-0-r2.ebuild,v 1.6 2011/03/07 12:07:35 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 jruby ree18"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby test/unit library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~ppc ~sh x86"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( dev-lang/ruby:1.8 )
	ruby_targets_jruby? ( dev-java/jruby )
	ruby_targets_ree18? ( dev-lang/ruby-enterprise:1.8 )"
DEPEND=""
