# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ruby-test-unit/ruby-test-unit-0-r1.ebuild,v 1.7 2011/03/07 12:07:35 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 jruby"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby test/unit library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( dev-lang/ruby:1.8 )
	ruby_targets_jruby? ( dev-java/jruby )"
DEPEND=""
