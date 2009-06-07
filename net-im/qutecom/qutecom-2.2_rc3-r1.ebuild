# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils eutils

MY_P=${P/_rc/-RC}

DESCRIPTION="Multi-protocol instant messenger and VoIP client"
HOMEPAGE="http://www.qutecom.com/"
SRC_URI="http://www.qutecom.com/downloads/${MY_P}.tar.gz
	http://omploader.org/vMTFvMg/qutecom_googlebreakpad_64.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug oss portaudio xv"

DEPEND=">=dev-libs/boost-1.34
	dev-libs/glib
	dev-libs/openssl
	alsa? ( media-libs/alsa-lib )
	media-libs/libsamplerate
	media-libs/libsndfile
	portaudio? ( media-libs/portaudio )
	media-libs/speex
	<media-video/ffmpeg-0.5
	net-im/pidgin[gnutls]
	net-libs/gnutls
	>=net-libs/libosip-3
	>=net-libs/libeXosip-3
	net-misc/curl
	|| ( x11-libs/libX11 virtual/x11 )
	x11-libs/qt-gui
	x11-libs/qt-svg
	xv? ( x11-libs/libXv )"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}

src_unpack() {
	# do not try to unpack googlebreakpad_64.patch
	# TODO: the patch should be compressed, internal or external
	unpack ${MY_P}.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}_wifo_phapi.patch
	epatch "${FILESDIR}"/${PN}_libpurple_gnutls.patch
	epatch "${DISTDIR}"/${PN}_googlebreakpad_64.patch

	# fix broken CMake conf file
	sed -i -e \
		"s/endif (PHAPI_CODEC_AMR_SUPPORT)/endif (PHAPI_CODEC_ILBC_SUPPORT)/" \
		wengophone/src/presentation/qt/CMakeLists-install-linux.txt \
		|| die "patching CMakeLists-install-linux.txt failed"
	sed -i -e \
		"/^if (PHAPI_CODEC_ILBC_SUPPORT)/i\
		endif (PHAPI_CODEC_AMR_SUPPORT)" \
		wengophone/src/presentation/qt/CMakeLists-install-linux.txt \
		|| die "patching CMakeLists-install-linux.txt failed"
}

src_configure() {
	local mycmakeargs="$(cmake-utils_use_enable portaudio PORTAUDIO_SUPPORT) \
		$(cmake-utils_use_enable alsa PHAPI_AUDIO_ALSA_SUPPORT) \
		$(cmake-utils_use_enable oss PHAPI_AUDIO_OSS_SUPPORT) \
		$(cmake-utils_use_enable xv WENGOPHONE_XV_SUPPORT) \
		-DLIBPURPLE_INTERNAL=OFF \
		-DPORTAUDIO_INTERNAL=OFF "

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	domenu wengophone/res/qutecom.desktop || die "domenu failed"
	doicon wengophone/res/wengophone_64x64.png || die "doicon failed"

}
